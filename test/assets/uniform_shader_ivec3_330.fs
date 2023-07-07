#version 330

uniform ivec3 vector;

void main() {
  gl_FragColor = vec4(vector, 1.0);
}
