
from dotbot.plugin import Plugin
from dotbot.dispatcher import Dispatcher

class Deferrer(Plugin):
    """Defer the run of some tasks until asked for

    Use `defer` to defer a list of actions
    Use `run_deferred` to run all deferred actions

    `defer` can take as argument:
        - a list of tasks (same as the root of YAML files)
        - a dict with the following keys:
            * id: an ID which uniquely identifies the set of tasks
            * tasks: the list of tasks

    If several `defer` with the same ID are registered, only the first
    one will be run.

    Example
    -------
    - defaults:
        link:
          relink: true

    - clean: ['~']

    - defer:
        - link:
            ~/.dotfiles: ''
            ~/.tmux.conf: tmux.conf
            ~/.vim: vim
            ~/.vimrc: vimrc
        - shell:
          - [git submodule update --init --recursive, Installing submodules]
    - shell:
        - echo "Do something else"
    - run_deferred:
    """
    _directives = ("defer", "run_deferred")

    def __init__(self, context):
        super().__init__(context)
        # dispatcher init should be deferred not to end in an infinite loop
        self._dispatcher = None
        self._deferred = []

    def can_handle(self, directive):
        return directive in self._directives

    def handle(self, directive, data):
        if directive in self._directives:
            return getattr(self, "_" + directive)(data)
        else:
            raise ValueError('Deferrer cannot handle directive %s' % directive)

    def _defer(self, data):
        self._log.lowinfo('Deferring %d tasks' % len(data))
        self._deferred.append(data)
        if self._dispatcher is None:
            self._dispatcher = Dispatcher(
                self._context.base_directory(),
                self._context.options(),
            )
        return True

    def _run_deferred(self, data):
        success = True
        # ensure _defer was called first
        if self._dispatcher is None:
            return success
        # ensure the context of deferred tasks is the same as current
        self._dispatcher._context.set_defaults(self._context.defaults())
        # to register which tasks have been run
        run_tasks = []
        for tasks in self._deferred:
            if isinstance(tasks, list):
                success &= self._dispatcher.dispatch(tasks)
            elif isinstance(tasks, dict):
                # skip already run tasks
                if "id" in tasks and tasks["id"] in run_tasks:
                    continue
                # run tasks
                if "tasks" in tasks:
                    success &= self._dispatcher.dispatch(tasks["tasks"])
                # register runned tasks
                if "id" in tasks:
                    run_tasks.append(tasks["id"])

        # reset the deferred tasks
        self._deferred = []
        if success:
            self._log.info('All deferred tasks have been executed')
        else:
            self._log.error('Some deferred tasks were not successfully')
        return success
