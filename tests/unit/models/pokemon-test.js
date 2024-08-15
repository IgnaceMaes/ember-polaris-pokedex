import { setupTest } from 'ember-embroider-pokedex/tests/helpers';
import { module, test } from 'qunit';

module('Unit | Model | pokemon', function (hooks) {
  setupTest(hooks);

  // Replace this with your real tests.
  test('it exists', function (assert) {
    const store = this.owner.lookup('service:store');
    const model = store.createRecord('pokemon', {});
    assert.ok(model, 'model exists');
  });
});
