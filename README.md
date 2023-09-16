# GlowX311
The way we approach visual aesthetics in digital environments.

# Example
<details> <summary>Initial</summary> <pre><code lang="lua">
  local GlowX311 = loadstring(game:HttpGet("https://github.com/Storm99999/GlowX311/blob/main/src/GlowX311.lua?raw=true"))()
  for i, player_instance in next, game.Players:GetPlayers() do
    GlowX311:CreatePointer(player_instance, {
      ['Highlight'] = true,
      ['HighlightColor'] = Color3.fromRGB(168, 106, 255),
      ['Gradient_Instance'] = nil,
      ['Glow_Color'] = Color3.fromRGB(168, 106, 255)
    })
  end
</code></pre> </details>
