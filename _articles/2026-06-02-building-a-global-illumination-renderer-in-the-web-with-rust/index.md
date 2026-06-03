---
layout: post
title:  "Building a Global Illumination Renderer in the Web with Rust"
date:   2026-06-02 12:00:00 -0400
slug: building-a-global-illumination-renderer-in-the-web-with-rust
published: false
---

Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

## The Cornell Box

Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.

<figure>
  <div id="quasi-canvas" style="position: relative; width: 540px; height: 540px; max-width: 100%; background: #000;">
    <div id="quasi-canvas-badge" style="position: absolute; top: 10px; left: 10px; padding: 3px 10px; border-radius: 16px; background-color: var(--ctp-surface0); border: 2px solid var(--border-color); color: var(--ctp-text); font-size: 11px; font-weight: 500; display: inline-flex; align-items: center; gap: 5px; pointer-events: none; user-select: none; transition: opacity 0.3s ease; z-index: 10;">
      <span aria-hidden="true" style="font-size: 18px; line-height: 1;">☞</span>
      <span style="font-family: 'Space Mono', monospace;">Interactive</span>
    </div>
  </div>
  <figcaption>The Cornell Box, path-traced live in your browser.</figcaption>
</figure>

<script type="module">
  import init, { create } from "{{ '/assets/demos/' | append: page.slug | append: '/quasi.js' | relative_url }}";

  const host = document.getElementById('quasi-canvas');
  const badge = document.getElementById('quasi-canvas-badge');
  host.addEventListener('pointerdown', () => {
    badge.style.opacity = '0';
    setTimeout(() => badge.remove(), 300);
  }, { once: true });

  // Keep the QuasiInstance alive — dropping it detaches the canvas listeners.
  const instances = [];
  init().then(async () => {
    instances.push(await create('quasi-canvas'));
  }).catch(console.error);
</script>

Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium
doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore
veritatis et quasi architecto beatae vitae dicta sunt explicabo.

<details markdown="1" class="collapsible-code">
<summary>Source: Cornell Box construction</summary>

```rust
// Rust
pub fn cornell_box() -> Scene {
    let white = mat([0.73, 0.73, 0.73], [0.0, 0.0, 0.0]);
    let red = mat([0.65, 0.05, 0.05], [0.0, 0.0, 0.0]);
    let green = mat([0.12, 0.45, 0.15], [0.0, 0.0, 0.0]);
    let light = mat([0.0, 0.0, 0.0], [15.0, 15.0, 15.0]);

    let mut scene = Scene {
        quads: Vec::new(),
        materials: Vec::new(),
        light_index: 0,
    };

    let push = |s: &mut Scene, q: GpuQuad, m: GpuMaterial| {
        s.quads.push(q);
        s.materials.push(m);
    };

    push(
        &mut scene,
        quad([-1.0, 0.0, -1.0], [2.0, 0.0, 0.0], [0.0, 0.0, 2.0]),
        white,
    ); // floor
    push(
        &mut scene,
        quad([-1.0, 2.0, 1.0], [2.0, 0.0, 0.0], [0.0, 0.0, -2.0]),
        white,
    ); // ceiling
    push(
        &mut scene,
        quad([-1.0, 0.0, -1.0], [2.0, 0.0, 0.0], [0.0, 2.0, 0.0]),
        white,
    ); // back
    push(
        &mut scene,
        quad([-1.0, 0.0, 1.0], [0.0, 0.0, -2.0], [0.0, 2.0, 0.0]),
        red,
    ); // left
    push(
        &mut scene,
        quad([1.0, 0.0, -1.0], [0.0, 0.0, 2.0], [0.0, 2.0, 0.0]),
        green,
    ); // right

    scene.light_index = scene.quads.len() as u32;
    push(
        &mut scene,
        quad([-0.25, 1.99, -0.25], [0.5, 0.0, 0.0], [0.0, 0.0, 0.5]),
        light,
    );

    add_box(&mut scene, [-0.35, 0.0, 0.3], [0.5, 1.2, 0.5], 15.0, white);
    add_box(
        &mut scene,
        [0.35, 0.0, -0.3],
        [0.55, 0.55, 0.55],
        -18.0,
        white,
    );

    scene
}
```
{:data-src="https://github.com/timthirion/quasi/blob/13e9da2/src/scene.rs#L134-L194"}

</details>

## Path Tracing in WGSL

At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis
praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias
excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui
officia deserunt mollitia animi, id est laborum et dolorum fuga.

<details markdown="1" class="collapsible-code" open>
<summary>Source: Cargo.toml dependencies</summary>

```toml
# Cargo.toml
[dependencies]
wgpu = "29"
log = "0.4"
bytemuck = { version = "1", features = ["derive"] }

[target.'cfg(not(target_arch = "wasm32"))'.dependencies]
winit = "0.29"
pollster = "0.3"
env_logger = "0.11"

[target.'cfg(target_arch = "wasm32")'.dependencies]
wasm-bindgen = "0.2"
wasm-bindgen-futures = "0.4"
js-sys = "0.3"
console_log = "1"
console_error_panic_hook = "0.1"
web-sys = { version = "0.3", features = [
    "Document",
    "Window",
    "Element",
    "Node",
    "HtmlElement",
    "HtmlCanvasElement",
    "CssStyleDeclaration",
    "EventTarget",
    "Event",
    "MouseEvent",
    "WheelEvent",
    "ResizeObserver",
    "IntersectionObserver",
    "IntersectionObserverEntry",
] }
```
{:data-src="https://github.com/timthirion/quasi/blob/13e9da2/Cargo.toml#L10-L44"}

</details>

<details markdown="1" class="collapsible-code" open>
<summary>Source: Ray-quad intersection</summary>

```wgsl
// WGSL
fn intersect_quad(ray: Ray, q: Quad, mat_idx: u32, t_min: f32, t_max: f32) -> Hit {
    var rec: Hit;
    rec.hit = false;

    let n = cross(q.u, q.v);
    let area_sq = dot(n, n);
    if (area_sq < 1e-8) {
        return rec;
    }
    let normal = n * inverseSqrt(area_sq);
    let d = dot(normal, q.origin);
    let denom = dot(normal, ray.dir);
    if (abs(denom) < 1e-8) {
        return rec;
    }
    let t = (d - dot(normal, ray.origin)) / denom;
    if (t < t_min || t > t_max) {
        return rec;
    }
    let p = ray.origin + ray.dir * t;
    let planar = p - q.origin;
    let w = n / area_sq;
    let alpha = dot(w, cross(planar, q.v));
    let beta = dot(w, cross(q.u, planar));
    if (alpha < 0.0 || alpha > 1.0 || beta < 0.0 || beta > 1.0) {
        return rec;
    }

    rec.hit = true;
    rec.t = t;
    rec.point = p;
    rec.mat = mat_idx;
    if (denom < 0.0) {
        rec.normal = normal;
    } else {
        rec.normal = -normal;
    }
    return rec;
}
```
{:data-src="https://github.com/timthirion/quasi/blob/13e9da2/src/shaders/pathtrace.wgsl#L92-L130"}

</details>

<details markdown="1" class="collapsible-code" open>
<summary>Source: Path-trace integrator</summary>

```wgsl
// WGSL
fn path_trace(ray_in: Ray, rng: ptr<function, u32>) -> vec3<f32> {
    var ray = ray_in;
    var color = vec3<f32>(0.0);
    var throughput = vec3<f32>(1.0);
    var specular_bounce = true;
    var prev_bsdf_pdf = 0.0;
    var prev_point = ray.origin;

    for (var bounce = 0; bounce < MAX_BOUNCES; bounce = bounce + 1) {
        let hit = trace_scene(ray);
        if (!hit.hit) {
            break;
        }
        let m = U.materials[hit.mat];
        let emit = max(m.emission.x, max(m.emission.y, m.emission.z));

        if (emit > 0.1) {
            if (specular_bounce) {
                color = color + throughput * m.emission;
            } else {
                let lp = light_pdf_solid_angle(prev_point, hit.point, hit.normal);
                var wmis = 1.0;
                if (lp > 0.0) {
                    wmis = power_heuristic(prev_bsdf_pdf, lp);
                }
                color = color + throughput * m.emission * wmis;
            }
            break;
        }

        // Next-event estimation.
        let ls = sample_light(hit.point, rng);
        if (ls.valid) {
            let cos_surf = dot(hit.normal, ls.wi);
            if (cos_surf > 0.0) {
                let shadow_o = hit.point + hit.normal * 0.001;
                if (!occluded(shadow_o, ls.wi, ls.dist)) {
                    let f = m.albedo / PI;
                    let bsdf_pdf = cos_surf / PI;
                    let wlight = power_heuristic(ls.pdf_w, bsdf_pdf);
                    color = color + throughput * f * cos_surf * ls.le * wlight / ls.pdf_w;
                }
            }
        }

        // BSDF sampling (cosine-weighted Lambertian).
        let wi = cosine_sample_hemisphere(hit.normal, rng);
        let cos_wi = max(dot(hit.normal, wi), 0.0);
        prev_bsdf_pdf = cos_wi / PI;
        prev_point = hit.point;
        specular_bounce = false;
        throughput = throughput * m.albedo;

        if (bounce > 2) {
            let pr = max(0.05, max(throughput.x, max(throughput.y, throughput.z)));
            if (rand(rng) > pr) {
                break;
            }
            throughput = throughput / pr;
        }

        ray.origin = hit.point + hit.normal * 0.001;
        ray.dir = wi;
    }
    return color;
}
```
{:data-src="https://github.com/timthirion/quasi/blob/13e9da2/src/shaders/pathtrace.wgsl#L281-L346"}

</details>

<details markdown="1" class="collapsible-code" open>
<summary>Source: Progressive accumulation</summary>

```wgsl
// WGSL
@fragment
fn fs_main(in: VsOut) -> @location(0) vec4<f32> {
    let coord = vec2<i32>(in.position.xy);
    let s = textureLoad(sample_tex, coord, 0);
    let p = textureLoad(accum_prev, coord, 0);
    let weight = 1.0 / f32(A.frame_count + 1u);
    return mix(p, s, weight);
}
```
{:data-src="https://github.com/timthirion/quasi/blob/13e9da2/src/shaders/accumulate.wgsl#L33-L39"}

</details>

## Next-Event Estimation

Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed
quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.
Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur,
adipisci velit.

<details markdown="1" class="collapsible-code" open>
<summary>Source: Sampling the area light</summary>

```wgsl
// WGSL
fn sample_light(p: vec3<f32>, rng: ptr<function, u32>) -> LightSample {
    var ls: LightSample;
    ls.valid = false;

    let q = U.quads[U.light_index];
    let r1 = rand(rng);
    let r2 = rand(rng);
    let x = q.origin + r1 * q.u + r2 * q.v;

    let n_un = cross(q.u, q.v);
    let area = length(n_un);
    if (area < 1e-8) {
        return ls;
    }
    let n_l = n_un / area;

    let dvec = x - p;
    let dist = length(dvec);
    if (dist < 1e-4) {
        return ls;
    }
    let wi = dvec / dist;
    let cos_l = dot(n_l, -wi);
    if (cos_l <= 0.0) {
        return ls;
    }

    ls.wi = wi;
    ls.dist = dist;
    ls.pdf_w = (dist * dist) / (cos_l * area);
    ls.le = U.materials[U.light_index].emission;
    ls.valid = true;
    return ls;
}
```
{:data-src="https://github.com/timthirion/quasi/blob/13e9da2/src/shaders/pathtrace.wgsl#L178-L211"}

</details>

## What's Next

Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus
saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae.
