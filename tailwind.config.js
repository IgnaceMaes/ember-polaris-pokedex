/** @type {import('tailwindcss').Config} */
export default {
  content: [`app/**/*.{js,ts,hbs,gjs,gts,html}`],
  theme: {
    extend: {
      animation: {
        wiggle: 'wiggle 0.5s ease-out',
        progress: 'progress 1s infinite linear',
      },
      keyframes: {
        wiggle: {
          '0%, 100%': { transform: 'rotate(0deg)' },
          '10%, 50%, 90%': { transform: 'rotate(-3deg)' },
          '30%, 70%': { transform: 'rotate(3deg)' },
        },
        progress: {
          '0%': { transform: ' translateX(0) scaleX(0)' },
          '40%': { transform: 'translateX(0) scaleX(0.4)' },
          '100%': { transform: 'translateX(100%) scaleX(0.5)' },
        },
      },
      transformOrigin: {
        'left-right': '0% 50%',
      },
    },
  },
  plugins: [],
};
