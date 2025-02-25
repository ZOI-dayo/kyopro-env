return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  config = function()
    local ls = require('luasnip')
    local snip = ls.snippet
    local text = ls.text_node
    local insert = ls.insert_node

    ls.add_snippets(nil, {
      cpp = {
        snip(
          {
            trig = 'graph_viz',
          }, {
            text({
              '#ifndef ONLINE_JUDGE',
              'GVC_t *gvc = gvContext();',
              'void show_graph(vvec<ll> g, string filename) {',
              '  Agraph_t *viz_g = agopen(const_cast<char*>(filename.c_str()), Agdirected, nullptr);',
              '  vec<Agnode_t*> node(g.size());',
              '  rep(i, g.size()) {',
              '    node[i] = agnode(viz_g, nullptr, true);',
              '',
              '    agsafeset(node[i], const_cast<char *>("label"), const_cast<char*>(to_string(i).c_str()), const_cast<char *>(""));',
              '  }',
              '  rep(i, g.size()) {',
              '    for(auto&& j : g[i]) {',
              '      agedge(viz_g, node[i], node[j], nullptr, true);',
              '    }',
              '  }',
              '  gvLayout(gvc, viz_g, "neato");',
              '  gvRenderFilename(gvc, viz_g, "png", filename.c_str());',
              '  gvFreeLayout(gvc, viz_g);',
              '  agclose(viz_g);',
              '}',
              '#else',
              'void show_graph(vvec<ll> &g, string filename) {}',
              '#endif',
            }),
          }
        ),
        snip(
          'segtree',
          {
            text({
              'using T = int;',
              'SegmentTree<T> '
            }),
            insert(1, 'seg'),
            text({'(n, [](T a, T b) { return a + b; }, 0);'}),
          }
        ),
        snip(
          'lazy-segtree:range-add-range-sum',
          {
            text({
              'using T = int;',
              'using F = int;',
              'LazySegmentTree<T, F> '
            }),
            insert(1, 'seg'),
            text({
              '(',
              '  n,',
              '  [](T a, T b) { return a + b; },',
              '  [](F fir, F sec) { return fir + sec; },',
              '  [](F f, T a, size_t len) { return a + len * f; },',
              '  0,',
              '  0',
              ');'
            }),
          }
        ),
        snip(
          'lazy-segtree:range-set-range-sum',
          {
            text({
              'using T = int;',
              'using F = nullable<int>;',
              'LazySegmentTree<T, F> '
            }),
            insert(1, 'seg'),
            text({
              '(',
              '  n,',
              '  [](T a, T b) { return a + b; },',
              '  [](F fir, F sec) { return sec ? sec : fir; },',
              '  [](F f, T a, size_t len) { return f ? *f * len : a; },',
              '  0,',
              '  nullptr',
              ');'
            }),
          }
        )
      }
    })
  end,
}
