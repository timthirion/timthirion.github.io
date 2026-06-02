# Custom Rouge lexer for WGSL (WebGPU Shading Language).
#
# Rouge ships GLSL and HLSL but not WGSL as of 4.7, so we register our own
# so blog code blocks tagged ```wgsl get syntax highlighting. Lives in
# _plugins/ which Jekyll loads at startup; GitHub Pages safe mode would
# refuse this, which is exactly why we now build via our own Actions
# workflow rather than GH Pages' built-in Jekyll.
#
# Grammar covers the WGSL 1.0 surface (https://www.w3.org/TR/WGSL/):
# keywords, types, address spaces, attributes (`@vertex`, `@group(0)`),
# builtin functions, numeric literals with type suffixes, and comments.

require "rouge"

module Rouge
  module Lexers
    class WGSL < RegexLexer
      title "WGSL"
      desc "WebGPU Shading Language (https://www.w3.org/TR/WGSL/)"
      tag "wgsl"
      filenames "*.wgsl"
      mimetypes "text/wgsl"

      KEYWORDS = %w[
        fn struct enable requires alias
        let var const const_assert override
        return if else for while loop break continue switch case default
        discard fallthrough
        true false
      ].freeze

      TYPES = %w[
        bool i32 u32 f32 f16
        vec2 vec3 vec4
        mat2x2 mat2x3 mat2x4 mat3x2 mat3x3 mat3x4 mat4x2 mat4x3 mat4x4
        array atomic ptr
        texture_1d texture_2d texture_2d_array texture_3d
        texture_cube texture_cube_array
        texture_multisampled_2d
        texture_depth_2d texture_depth_2d_array
        texture_depth_cube texture_depth_cube_array
        texture_depth_multisampled_2d
        texture_storage_1d texture_storage_2d texture_storage_2d_array
        texture_storage_3d
        texture_external
        sampler sampler_comparison
      ].freeze

      ADDRESS_SPACES = %w[
        function private workgroup uniform storage handle
        read read_write write
      ].freeze

      BUILTINS = %w[
        abs acos acosh all any asin asinh atan atan2 atanh
        bitcast ceil clamp cos cosh countLeadingZeros countOneBits
        countTrailingZeros cross degrees determinant distance dot
        exp exp2 extractBits faceForward firstLeadingBit firstTrailingBit
        floor fma fract frexp inverseSqrt ldexp length log log2
        max min mix modf normalize pow quantizeToF16 radians reflect refract
        reverseBits round saturate select sign sin sinh smoothstep sqrt
        step tan tanh transpose trunc
        dpdx dpdxCoarse dpdxFine dpdy dpdyCoarse dpdyFine fwidth fwidthCoarse fwidthFine
        textureDimensions textureGather textureGatherCompare textureLoad
        textureNumLayers textureNumLevels textureNumSamples
        textureSample textureSampleBias textureSampleCompare
        textureSampleCompareLevel textureSampleGrad textureSampleLevel
        textureSampleBaseClampToEdge textureStore
        atomicLoad atomicStore atomicAdd atomicSub atomicMax atomicMin
        atomicAnd atomicOr atomicXor atomicExchange atomicCompareExchangeWeak
        pack2x16float pack2x16snorm pack2x16unorm pack4x8snorm pack4x8unorm
        unpack2x16float unpack2x16snorm unpack2x16unorm
        unpack4x8snorm unpack4x8unorm
        storageBarrier workgroupBarrier workgroupUniformLoad
        arrayLength
      ].freeze

      state :root do
        rule %r{//[^\n]*}, Comment::Single
        rule %r{/\*}, Comment::Multiline, :multiline_comment
        rule %r{\s+}, Text

        # Attributes: @vertex, @fragment, @group(0), @builtin(position), …
        rule %r{@\w+}, Name::Decorator

        # Numbers (longest match first so 1.0f beats 1u).
        rule %r{0[xX][0-9a-fA-F]+\.[0-9a-fA-F]*([pP][+-]?\d+)?[fh]?}, Num::Float
        rule %r{0[xX][0-9a-fA-F]*\.[0-9a-fA-F]+([pP][+-]?\d+)?[fh]?}, Num::Float
        rule %r{\d+\.\d*([eE][+-]?\d+)?[fh]?}, Num::Float
        rule %r{\.\d+([eE][+-]?\d+)?[fh]?}, Num::Float
        rule %r{\d+[eE][+-]?\d+[fh]?}, Num::Float
        rule %r{0[xX][0-9a-fA-F]+[uifh]?}, Num::Hex
        rule %r{\d+[uifh]?}, Num::Integer

        rule %r{\b(?:#{KEYWORDS.join("|")})\b}, Keyword
        rule %r{\b(?:#{TYPES.join("|")})\b}, Keyword::Type
        rule %r{\b(?:#{ADDRESS_SPACES.join("|")})\b}, Keyword::Reserved
        rule %r{\b(?:#{BUILTINS.join("|")})\b}, Name::Builtin

        rule %r{[a-zA-Z_]\w*}, Name
        rule %r{[+\-*/%<>=!&|\^~?:]+}, Operator
        rule %r{[(){}\[\];,.]}, Punctuation
      end

      state :multiline_comment do
        rule %r{[^*/]+}, Comment::Multiline
        rule %r{\*/}, Comment::Multiline, :pop!
        rule %r{[*/]}, Comment::Multiline
      end
    end
  end
end
