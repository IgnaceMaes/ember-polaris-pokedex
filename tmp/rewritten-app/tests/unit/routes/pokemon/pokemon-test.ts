import { module, test } from 'qunit';
import { setupTest } from 'ember-polaris-pokedex/tests/helpers';

module('Unit | Route | pokemon/:pokemon', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    let route = this.owner.lookup('route:pokemon/pokemon');
    assert.ok(route);
  });
});
