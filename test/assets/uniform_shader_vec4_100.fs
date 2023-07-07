#version 100

precision mediump float;

uniform vec4 vector;

void main() {
  gl_FragColor = vector;
}
