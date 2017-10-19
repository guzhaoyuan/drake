#/bin/bash
# Unit test for lcm_vector_gen.py.
# This test should only be run via Bazel, never directly on the command line.

set -ex

# Dump some debugging output.
find .

# Move the originals (which are symlinks) out of the way.
tool_outputs="lcmt_sample_t.lcm sample.cc sample.h sample_translator.cc 
  sample_translator.h"
for item in $tool_outputs; do
  test -L drake/tools/test/gen/"$item"  # Fail-fast if not under Bazel.
  mv drake/tools/test/gen/"${item}"{,.orig}
done

# Run the code generator.
# TODO(jwnimmer-tri) De-duplicate this with lcm_vector_gen.sh.
./drake/tools/lcm_vector_gen \
  --lcmtype-dir="drake/tools/test/gen" \
  --cxx-dir="drake/tools/test/gen" \
  --namespace="drake::tools::test" \
  --workspace=$(pwd) \
  --named_vector_file="drake/tools/test/sample.named_vector"

# Dump some debugging output.
find drake/tools/test/gen

# Insist that the generated output matches the current copy in git.
for item in $tool_outputs; do
  diff --unified=20 drake/tools/test/gen/"${item}"{.orig,}
done

echo "PASS"
