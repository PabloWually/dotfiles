local setup, comment = pcall(require, "Comment")
if not setup then
	return
end
require("legendary").keymaps({
	{
		":Comment",
		{
			n = "gcc",
			v = "gc",
		},
		description = "Toggle comment",
	},
})
comment.setup()
