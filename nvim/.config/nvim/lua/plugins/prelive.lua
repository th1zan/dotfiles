return {
  "hat0uma/prelive.nvim",
  opts = {},
  cmd = {
    "PreLiveGo",
    "PreLiveStatus",
    "PreLiveClose",
    "PreLiveCloseAll",
    "PreLiveLog",
  },
  config = function()
    require("prelive").setup({
      server = {
        host = "127.0.0.1",
        port = 2255,
      },
      http = {
        tcp_max_backlog = 16,
        tcp_recv_buffer_size = 1024,
        keep_alive_timeout = 60 * 1000,
        max_body_size = 1024 * 1024 * 1,
        max_request_line_size = 1024 * 4,
        max_header_field_size = 1024 * 4,
        max_header_num = 100,
        max_chunk_ext_size = 1024 * 1,
      },
      log = {
        print_level = vim.log.levels.WARN,
        file_level = vim.log.levels.DEBUG,
        max_file_size = 1 * 1024 * 1024,
        max_backups = 3,
      },
    })
  end,
}
