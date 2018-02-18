#ifdef GL_ES
precision mediump float;
#endif
 
#define PROCESSING_COLOR_SHADER
 
uniform float time;
uniform vec2 mouse;
uniform vec2 resolution;
 
uniform float mean;
uniform float contrast;
uniform float tper;
uniform float sper;
uniform float th;
uniform float th_speed;
 
const float PI = 3.1415926535;

void main( void ) {
 
float sth = sin(th);
float cth = cos(th);
 
float color = 0.5+contrast*sin(2.0*PI*((gl_FragCoord.x/sper*cth + gl_FragCoord.y/sper*sth)+time));
 
gl_FragColor = vec4( color, color, color, 1.0 );

}