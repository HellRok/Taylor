#version 330

uniform vec2 vector;

void main() {
  gl_FragColor = vec4(vector, 0, 1.0);
}
