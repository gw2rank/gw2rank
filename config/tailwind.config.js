const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('daisyui'),
  ],
  daisyui: {
    themes: [
      {
        gwrank: {
          "primary": "#69278A",
          "secondary": "#186885",
          "accent": "#37CDBE",
          "neutral": "#666666",
          "base-100": "#1F1D29",
          "info": "#3399CC",
          "success": "#339966",
          "warning": "#FF9933",
          "error": "#EC5752",
	},
      },
    ],
  },
}
