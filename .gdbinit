python
import sys
sys.path.insert(0, "$XDG_DATA_HOME/gdb_python")
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (None)
end

