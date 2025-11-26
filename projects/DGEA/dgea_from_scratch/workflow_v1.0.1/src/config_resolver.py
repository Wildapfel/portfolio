import re




class ResolveConfig:


    # Expand a config file accoridng to the depencies withing the config file.
    
    # Usage:
    # Specfiy with [...] (withing corner brackets) the relative path to another
    # entry in the dictionary (config.yml). This gets expanded util there exist
    # no more links.  
    
    # Hint:
    # Use {widlcard} to specify a wildcard expression in a single line of relative paths
    # this gets resolved from the Snakefile. 


    def __init__(self, cfg):

        self.PATTERN = r"\[([^\[\]]+)\]"    # [...]
        # pattern = r"\[([^\}]+)\]"         # {...}  old pattern from dev
        self.cfg = cfg


    def _lookup(self, path):
        parts = path.split(".")
        val = self.cfg
        for p in parts:
            val = val[p]
        return val


    def _expand(self, value):

        if isinstance(value, str):
            # Keep expanding until there are no more {…}
            while re.search(self.PATTERN, value):
                value = re.sub(self.PATTERN, lambda m: str(self._lookup(m.group(1))), value)
            return value

        elif isinstance(value, dict):
            return {k: self._expand(v) for k, v in value.items()}

        elif isinstance(value, list):
            return [self._expand(v) for v in value]

        else:
            return value


    def resolve_config(self, cfg):

        """Recursively expand [paths.ref] and nested references in config dict."""

        return self._expand(cfg)

