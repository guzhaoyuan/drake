# Drake simulate halodi robot

To run this simulation
```
cd drake
bazel-bin/tools/drake_visualizer &
bazel run //examples/eve:run_eve_IDC_demo -- --simulation_time=5
```

The robot model is under drake/manipulation/models/eve/

The code is under drake/examples/eve/
