#version 330

uniform int red;
uniform int green;
uniform int blue;

void main() {
  gl_FragColor = vec4(red, green, blue, 1.0);
}
