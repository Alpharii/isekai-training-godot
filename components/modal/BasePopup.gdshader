shader_type canvas_item;

// Mengambil gambar dari apa yang ada di belakang UI
uniform sampler2D screen_texture : hint_screen_texture, filter_linear_mipmap;
// Variabel untuk mengontrol tingkat keburaman (bisa diatur lewat Inspector)
uniform float blur_amount : hint_range(0.0, 5.0) = 2.5;
// Variabel untuk memberikan efek menggelapkan (vignette/tint)
uniform vec4 mix_color : source_color = vec4(0.0, 0.0, 0.0, 0.3);

void fragment() {
    // Membaca warna layar di belakang node ini dengan efek blur
    vec4 blurred_color = textureLod(screen_texture, SCREEN_UV, blur_amount);
    // Menggabungkan warna blur dengan warna gelap pilihan kita
    COLOR = mix(blurred_color, mix_color, mix_color.a);
}