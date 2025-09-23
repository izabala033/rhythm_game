shader_type canvas_item;

uniform vec2 viewport_size;
uniform float beat_strength;
uniform float time;

void fragment() {
    vec2 uv = FRAGCOORD.xy / viewport_size;
    vec2 center = vec2(0.5, 0.5);
    vec2 to_center = uv - center;
    float dist = length(to_center);

    // Radial pulse reacting to beat
    float pulse = sin(dist * 20.0 - time * 5.0) * 0.5 + 0.5;
    pulse *= beat_strength;

    // Dynamic color waves
    vec3 color = vec3(
        0.5 + 0.5 * sin(time * 2.0 + dist * 10.0),
        0.5 + 0.5 * sin(time * 3.0 + dist * 15.0),
        0.5 + 0.5 * sin(time * 4.0 + dist * 20.0)
    );

    color += pulse;

    COLOR = vec4(color, 1.0);
}
