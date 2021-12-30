function get(color, index)
  local colors
  if vim.g.light_theme == nil or not vim.g.light_theme then
    colors = github.dark
  else
    colors = github.light
    return
  end
  c = colors[color]
  if c == nil then
    error(string.format("failed to find color %s", color))
  end
  hex = c[index]
  if hex == nil then
    error(string.format("failed to index %d of color %s", index, color))
  end
  return hex
end

print(get('blue', 100))

github = {
	-- https://github.com/primer/primitives/blob/main/data/colors/themes/dark.ts
	dark = {
    black = '#010409',
    white = '#f0f6fc',
    gray = {'#f0f6fc', '#c9d1d9', '#b1bac4', '#8b949e', '#6e7681', '#484f58', '#30363d', '#21262d', '#161b22', '#0d1117'},
    blue = {'#cae8ff', '#a5d6ff', '#79c0ff', '#58a6ff', '#388bfd', '#1f6feb', '#1158c7', '#0d419d', '#0c2d6b', '#051d4d'},
    green = {'#aff5b4', '#7ee787', '#56d364', '#3fb950', '#2ea043', '#238636', '#196c2e', '#0f5323', '#033a16', '#04260f'},
    yellow = {'#f8e3a1', '#f2cc60', '#e3b341', '#d29922', '#bb8009', '#9e6a03', '#845306', '#693e00', '#4b2900', '#341a00'},
    orange = {'#ffdfb6', '#ffc680', '#ffa657', '#f0883e', '#db6d28', '#bd561d', '#9b4215', '#762d0a', '#5a1e02', '#3d1300'},
    red = {'#ffdcd7', '#ffc1ba', '#ffa198', '#ff7b72', '#f85149', '#da3633', '#b62324', '#8e1519', '#67060c', '#490202'},
    purple = {'#eddeff', '#e2c5ff', '#d2a8ff', '#bc8cff', '#a371f7', '#8957e5', '#6e40c9', '#553098', '#3c1e70', '#271052'},
    pink = {'#ffdaec', '#ffbedd', '#ff9bce', '#f778ba', '#db61a2', '#bf4b8a', '#9e3670', '#7d2457', '#5e103e', '#42062a'},
    coral = {'#FFDDD2', '#FFC2B2', '#FFA28B', '#F78166', '#EA6045', '#CF462D', '#AC3220', '#872012', '#640D04', '#460701'}
  },
	-- https://github.com/primer/primitives/blob/main/data/colors/themes/light.ts
	light =  {
  	black = '#1b1f24',
    white = '#ffffff',
    gray = {'#f6f8fa', '#eaeef2', '#d0d7de', '#afb8c1', '#8c959f', '#6e7781', '#57606a', '#424a53', '#32383f', '#24292f'},
    blue = {'#ddf4ff', '#b6e3ff', '#80ccff', '#54aeff', '#218bff', '#0969da', '#0550ae', '#033d8b', '#0a3069', '#002155'},
    green = {'#dafbe1', '#aceebb', '#6fdd8b', '#4ac26b', '#2da44e', '#1a7f37', '#116329', '#044f1e', '#003d16', '#002d11'},
    yellow = {'#fff8c5', '#fae17d', '#eac54f', '#d4a72c', '#bf8700', '#9a6700', '#7d4e00', '#633c01', '#4d2d00', '#3b2300'},
    orange = {'#fff1e5', '#ffd8b5', '#ffb77c', '#fb8f44', '#e16f24', '#bc4c00', '#953800', '#762c00', '#5c2200', '#471700'},
    red = {'#FFEBE9', '#ffcecb', '#ffaba8', '#ff8182', '#fa4549', '#cf222e', '#a40e26', '#82071e', '#660018', '#4c0014'},
    purple = {'#fbefff', '#ecd8ff', '#d8b9ff', '#c297ff', '#a475f9', '#8250df', '#6639ba', '#512a97', '#3e1f79', '#2e1461'},
    pink = {'#ffeff7', '#ffd3eb', '#ffadda', '#ff80c8', '#e85aad', '#bf3989', '#99286e', '#772057', '#611347', '#4d0336'},
    coral = {'#FFF0EB', '#FFD6CC', '#FFB4A1', '#FD8C73', '#EC6547', '#C4432B', '#9E2F1C', '#801F0F', '#691105', '#510901'},
	},
}
