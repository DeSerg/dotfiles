python
import sys
import os
pp_path = os.path.expandvars("$XDG_DATA_HOME/gdb_python")
sys.path.insert(0, pp_path)
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end

