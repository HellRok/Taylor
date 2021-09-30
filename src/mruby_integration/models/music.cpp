#include <cstdlib>
#include "raylib.h"
#include "mruby.h"
#include "mruby/data.h"
#include "mruby/class.h"
#include "mruby/compile.h"

#include "mruby_integration/helpers.hpp"
#include "mruby_integration/struct_types.hpp"

struct RClass *Music_class;

void setup_Music(mrb_state *mrb, mrb_value object, Music *music, int context_type, bool looping, int sample_count) {
  ivar_attr_int(mrb, object, music->ctxType, context_type);
  ivar_attr_bool(mrb, object, music->looping, looping);
  ivar_attr_int(mrb, object, music->sampleCount, sample_count);
}

mrb_value mrb_Music_initialize(mrb_state *mrb, mrb_value self) {
  mrb_int context_type, sample_count;
  mrb_bool looping;
  mrb_get_args(mrb, "ibi", &context_type, &looping, &sample_count);

  Music *music = (struct Music *)DATA_PTR(self);
  if (music) { mrb_free(mrb, music); }
  mrb_data_init(self, nullptr, &Music_type);
  music = (Music *)malloc(sizeof(Music));

  setup_Music(mrb, self, music, context_type, looping, sample_count);

  mrb_data_init(self, music, &Music_type);
  return self;
}

mrb_value mrb_Music_set_context_type(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Music_type, Music, ctxType, context_type);
}

mrb_value mrb_Music_set_looping(mrb_state *mrb, mrb_value self) {
  attr_setter_bool(mrb, self, Music_type, Music, looping, looping);
}

mrb_value mrb_Music_set_sample_count(mrb_state *mrb, mrb_value self) {
  attr_setter_int(mrb, self, Music_type, Music, sampleCount, sample_count);
}

void append_models_Music(mrb_state *mrb) {
  Music_class = mrb_define_class(mrb, "Music", mrb->object_class);
  MRB_SET_INSTANCE_TT(Music_class, MRB_TT_DATA);
  mrb_define_method(mrb, Music_class, "initialize", mrb_Music_initialize, MRB_ARGS_REQ(3));
  mrb_define_method(mrb, Music_class, "context_type=", mrb_Music_set_context_type, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Music_class, "looping=", mrb_Music_set_looping, MRB_ARGS_REQ(1));
  mrb_define_method(mrb, Music_class, "sample_count=", mrb_Music_set_sample_count, MRB_ARGS_REQ(1));

  mrb_load_string(mrb, R"(
    class Music
      attr_reader :context_type, :looping, :sample_count, :volume, :pitch

      def to_h
        {
          context_type: context_type,
          looping: looping,
          sample_count: sample_count,
        }
      end

      def self.load(path)
        raise Music::NotFound.new("Could not find file at path \"#{path}\"") unless File.exist?(path)
        load_music_stream(path).tap { |music|
          music.volume = 1
          music.pitch = 1
          }
      end

      def unload
        unload_music_stream(self)
      end

      def play
        play_music_stream(self)
      end

      def update
        update_music_stream(self)
      end

      def playing?
        music_playing?(self)
      end

      def stop
        stop_music_stream(self)
      end

      def pause
        pause_music_stream(self)
      end

      def resume
        resume_music_stream(self)
      end

      def length
        get_music_time_length(self)
      end

      def played
        get_music_time_played(self)
      end

      def volume=(value)
        unless (0..1).include?(value)
          raise ArgumentError, "Value must fall between 0 and 1, you gave me #{value}"
        end
        @volume = value

        set_music_volume(self, value)
      end

      def pitch=(value)
        @pitch = value
        set_music_pitch(self, value)
      end

      class NotFound < StandardError; end
      class Type
        NONE = 0
        WAV  = 1
        OGG  = 2
        FLAC = 3
        MP3  = 4
        XM   = 5
        MO   = 6
      end
    end
  )");
}
