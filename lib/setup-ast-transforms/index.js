'use strict';

const { installScopedCSS } = require('glimmer-scoped-css');

module.exports = {
  name: require('./package').name,
  setupPreprocessorRegistry(type, registry) {
    if (type === 'parent') {
      installScopedCSS(registry);
    }
  },
};
