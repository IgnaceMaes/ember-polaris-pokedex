import type { TOC } from '@ember/component/template-only';
import { LinkTo } from '@ember/routing';

const HomeButton: TOC<object> = <template>
  <LinkTo
    @route='index'
    class='relative inline-flex items-center justify-center hover:drop-shadow-lg p-0.5 mb-16 me-2 overflow-hidden text-sm font-medium text-gray-900 rounded-lg group bg-gradient-to-br from-pink-500 to-orange-400 group-hover:from-pink-500 group-hover:to-orange-400 hover:text-white focus:ring-4 focus:outline-none focus:ring-pink-200'
  >
    <span
      class='relative px-5 py-2.5 transition-all ease-in duration-75 bg-white rounded-md group-hover:bg-opacity-0'
    >⬅️ back
    </span>
  </LinkTo>
</template>;

export default HomeButton;
