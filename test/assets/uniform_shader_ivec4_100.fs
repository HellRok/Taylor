#version 100

precision mediump float;

uniform ivec4 vector;

void main() {
  gl_FragColor = vec4(vector);
}
