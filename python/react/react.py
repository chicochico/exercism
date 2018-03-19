class Cell(object):
    def __init__(self, value=None, deps=[], updater=None):
        self.value = value
        self.watchers_callbacks = []
        self.deps = deps
        self.deps_values = []
        self.updater = updater

    def __repr__(self):
        return f'Cell({self.value})'

    def set_value(self, value=None):
        old_value = self.value
        self.value = value
        # make callbacks only if value has changed
        if old_value != self.value:
            for callback in self.watchers_callbacks:
                callback(self, self.value)

    def update_callback(self, value):
        self.deps_values.append(value)
        if len(self.deps_values) == len(self.deps):
            # if all dependendencies have been updated
            self.set_value(self.updater(self.deps_values))
            self.deps_values = []

    def add_watcher(self, watcher_callback):
        self.watchers_callbacks.append(watcher_callback)

    def remove_watcher(self, watcher_callback):
        self.watchers_callbacks.remove(watcher_callback)


class Reactor(object):
    def create_input_cell(self, value):
        return Cell(value)

    def create_compute_cell(self, deps, updater_callback):
        computed = Cell(deps=deps, updater=updater_callback)
        deps_values = [dep.value for dep in deps]
        computed.set_value(updater_callback(deps_values))
        for dep in deps:
            dep.add_watcher(lambda _, value: computed.update_callback(value))
        return computed
