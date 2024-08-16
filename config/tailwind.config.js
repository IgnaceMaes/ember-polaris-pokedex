const path = require('path');

const appRoot = path.join(__dirname, '../');
const libraries = [
  /* someLibraryName */
];

const libraryPaths = libraries.map((name) =>
  path.dirname(require.resolve(name)),
);

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    `${appRoot}/app/**/*.{js,ts,hbs,gjs,gts,html}`,
    ...libraryPaths.map(
      (libraryPath) => `${libraryPath}/**/*.{js,ts,hbs,gjs,gts,html}`,
    ),
  ],
  theme: {
    extend: {
      animation: {
        wiggle: 'wiggle 0.5s ease-out',
      },
      keyframes: {
        wiggle: {
          '0%, 100%': { transform: 'rotate(0deg)' },
          '10%, 50%, 90%': { transform: 'rotate(-3deg)' },
          '30%, 70%': { transform: 'rotate(3deg)' },
        },
      },
    },
  },
  plugins: [],
};
