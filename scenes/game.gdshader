shader_type canvas_item;

uniform float pixel_size = 1;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
    vec2 screen_size = vec2(textureSize(SCREEN_TEXTURE, 0));
    vec2 uv = SCREEN_UV * screen_size;
    uv = floor(uv / pixel_size) * pixel_size;
    uv /= screen_size;
    COLOR = textureLod(SCREEN_TEXTURE, uv, 0.0);
}