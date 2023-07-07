#version 330

uniform vec3 vector;

void main() {
  gl_FragColor = vec4(vector, 1.0);
}
