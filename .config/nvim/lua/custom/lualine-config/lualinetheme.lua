local colors = {
  black = '#1e1e2e',
  white = '#cdd6f4',
  red = '#f44747', -- 🔴 Brighter red for Replace mode
  green = '#4ec9b0', -- 🟢 More vibrant green for Insert mode
  blue = '#569cd6', -- 🔵 Normal mode stays blue
  yellow = '#dcdcaa', -- 🟡 Softer yellow for Command mode
  gray = '#858585',
  darkgray = '#313244',
  lightgray = '#3e4451',
  inactivegray = '#6c7086',
  neonpink = '#ff79c6', -- 🎨 Visual mode stays Neon Pink
  purple = '#c678dd', -- 💜 Purple for Command mode
  teal = '#56b6c2',
  orange = '#d7875f',
}

return {
  normal = {
    a = { bg = colors.blue, fg = colors.black, gui = 'bold' }, -- 🔵 Normal mode (blue)
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.darkgray, fg = colors.white },
  },
  insert = {
    a = { bg = colors.green, fg = colors.black, gui = 'bold' }, -- 🟢 Insert mode (teal)
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.lightgray, fg = colors.white },
  },
  visual = {
    a = { bg = colors.neonpink, fg = colors.black, gui = 'bold' }, -- 🎨 Visual mode (Neon Pink)
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.inactivegray, fg = colors.black },
  },
  replace = {
    a = { bg = colors.red, fg = colors.black, gui = 'bold' }, -- 🔴 Replace mode (Bright Red)
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.black, fg = colors.white },
  },
  command = {
    a = { bg = colors.purple, fg = colors.black, gui = 'bold' }, -- 💜 Command mode (Purple)
    b = { bg = colors.lightgray, fg = colors.white },
    c = { bg = colors.inactivegray, fg = colors.black },
  },
  inactive = {
    a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.gray },
    c = { bg = colors.darkgray, fg = colors.gray },
  },
}
