#!/bin/bash
test -f .version && rm .version
describe versioner

  it "should create a new version file if called without parameters"
    ./versioner >/dev/null
    test -f .version
    assert equal "$?" "0"
    rm .version
  end

  it "should give 0.0.0 as initial version if called without parameters"
    assert equal "$(./versioner)" "0.0.0"
    rm .version
  end

  it "should give 0.0.1 as version if called with -i 0.0.1"
    assert equal "$(./versioner -i 0.0.1)" "0.0.1"
    rm .version
  end

  it "should give 1.1.1 as version if called with VERSIONER_INIT_VERSION=1.1.1"
    assert equal "$(VERSIONER_INIT_VERSION=1.1.1 ./versioner)" "1.1.1"
    rm .version
  end

  it "should write the version to a different file if it's given with -f"
    test -f .version2 && rm .version2
    ./versioner -f .version2 >/dev/null
    test -f .version2
    assert equal "$?" "0"
    rm .version2
  end

  it "should bump the patch level if called with -p, even multiple times in a row"
    test -f .version && rm .version
    assert equal "$(./versioner -p)" "0.0.1"
    assert equal "$(./versioner -p)" "0.0.2"
    assert equal "$(./versioner -p)" "0.0.3"
    assert equal "$(./versioner -p)" "0.0.4"
    assert equal "$(./versioner -p)" "0.0.5"
    rm .version
  end

  it "should bump the minor level if called with -m, even multiple times in a row"
    test -f .version && rm .version
    assert equal "$(./versioner -m)" "0.1.0"
    assert equal "$(./versioner -m)" "0.2.0"
    assert equal "$(./versioner -m)" "0.3.0"
    assert equal "$(./versioner -m)" "0.4.0"
    assert equal "$(./versioner -m)" "0.5.0"
    rm .version
  end

  it "should bump the major level if called with -M, even multiple times in a row"
    test -f .version && rm .version
    assert equal "$(./versioner -M)" "1.0.0"
    assert equal "$(./versioner -M)" "2.0.0"
    assert equal "$(./versioner -M)" "3.0.0"
    assert equal "$(./versioner -M)" "4.0.0"
    assert equal "$(./versioner -M)" "5.0.0"
    rm .version
  end

  it "should reset lower level numbers if bumped in a higher level"
    test -f .version && rm .version
    assert equal "$(./versioner -p)" "0.0.1"
    assert equal "$(./versioner -m)" "0.1.0"
    assert equal "$(./versioner -M)" "1.0.0"
    assert equal "$(./versioner -p)" "1.0.1"
    assert equal "$(./versioner -m)" "1.1.0"
    assert equal "$(./versioner -M)" "2.0.0"
    rm .version
  end

  it "should give the current version if called without parameters"
    test -f .version && rm .version
    assert equal "$(./versioner -M)" "1.0.0"
    assert equal "$(./versioner -m)" "1.1.0"
    assert equal "$(./versioner -p)" "1.1.1"
    assert equal "$(./versioner)" "1.1.1"
    rm .version
  end

  it "should show you your help if asked"
    assert glob  "$(./versioner -h| head -n1 )" "Usage:*"
    test -f .version && rm .version
    end

  it "should append a suffix if called with -a <suffix>"
    test -f .version && rm .version
    assert equal "$(./versioner -m -a -RC1)" "0.1.0-RC1"
    rm .version
  end
  it "should not write saied suffix to the version file"
    test -f .version && rm .version
    assert equal "$(./versioner -m -a -RC1)" "0.1.0-RC1"
    assert equal "$(./versioner)" "0.1.0"
    rm .version
  end

  end


end
