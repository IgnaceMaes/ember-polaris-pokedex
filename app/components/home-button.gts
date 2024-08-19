import type { TOC } from '@ember/component/template-only';
import { LinkTo } from '@ember/routing';

const HomeButton: TOC<object> = <template>
  <LinkTo
    @route='index'
    class='group relative mb-16 me-2 inline-flex items-center justify-center overflow-hidden rounded-lg bg-gradient-to-br from-pink-500 to-orange-400 p-0.5 text-sm font-medium text-gray-900 hover:text-white hover:drop-shadow-lg focus:outline-none focus:ring-4 focus:ring-pink-200 group-hover:from-pink-500 group-hover:to-orange-400'
  >
    <span
      class='relative rounded-md bg-white px-5 py-2.5 transition-all duration-75 ease-in group-hover:bg-opacity-0'
    >⬅️ back
    </span>
  </LinkTo>
</template>;

export default HomeButton;
