import os
import subprocess
from dotbot.dispatcher import Dispatcher
from dotbot.plugin import Plugin


class Condition(Plugin):
    """Perform actions only if a condition worked

    This plugin takes 2 arguments
    ```yaml
    - condition:
        if: <shell expression>
        then:
        - …
        - …
    ```
    """
    _directive = "condition"

    def can_handle(self, directive):
        return directive == self._directive

    def handle(self, directive, data):
        if directive != self._directive:
            raise ValueError("Condition cannot handle directive %s" % directive)
        return self._process(data)

    def _test_success(self, command):
        with open(os.devnull, 'w') as devnull:
            ret = subprocess.call(
                command,
                shell=True,
                stdout=devnull,
                stderr=devnull,
                executable=os.environ.get('SHELL'),
            )
        if ret != 0:
            self._log.debug('Test \'%s\' returned false' % command)
        else:
            self._log.debug('Test \'%s\' returned true' % command)
        return ret == 0

    def _run_tasks(self, tasks):
        success = True
        # create the dispatcher
        dispatcher = Dispatcher(self._context.base_directory())
        # ensure the context of deferred tasks is the same as current
        dispatcher._context.set_defaults(self._context.defaults())
        # run all tasks
        success &= dispatcher.dispatch(tasks)
        return success

    def _process(self, data):
        success = True
        # get the config
        test = data["if"]
        tasks = data["then"]

        # run test first
        if self._test_success(test):
            self._log.lowinfo('Running conditional tasks')
            success &= self._run_tasks(tasks)

            if success:
                self._log.info("All tasks were successful")
            else:
                self._log.error("Some tasks were not successful")
        else:
            self._log.lowinfo('Skipping tasks (condition not met)')
        return success
