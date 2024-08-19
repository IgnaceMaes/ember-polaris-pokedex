'use strict';

module.exports = {
  extends: 'recommended',
  rules: {
    'no-forbidden-elements': ['meta', 'html', 'script'], // Allow usage of `style`
  },
};
