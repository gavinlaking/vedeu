# frozen_string_literal: true

Vedeu.interface :test1_interface do
  border do
    title 'Test 1'
  end
  geometry do
    x  4
    y  3
    xn 35
    yn 8
  end
end

Vedeu.interface :help1_interface do
  geometry do
    x  use(:test1_interface).x
    y  use(:test1_interface).south
    xn use(:test1_interface).xn
    yn use(:test1_interface).south(5)
  end
end

Vedeu.interface :test2_interface do
  border do
    title 'Test 2'
  end
  geometry do
    x      use(:test1_interface).east(6)
    y      use(:test1_interface).y
    width  use(:test1_interface).width
    height use(:test1_interface).height
  end
end

Vedeu.interface :help2_interface do
  geometry do
    x  use(:test2_interface).x
    y  use(:test2_interface).south
    xn use(:test2_interface).xn
    yn use(:test2_interface).south(5)
  end
end

Vedeu.interface :test3_interface do
  border do
    title 'Test 3'
  end
  geometry do
    x  use(:help1_interface).x
    y  use(:help1_interface).south
    xn use(:help1_interface).xn
    yn use(:help1_interface).south(5)
  end
end

Vedeu.interface :help3_interface do
  geometry do
    x  use(:test3_interface).x
    y  use(:test3_interface).south
    xn use(:test3_interface).xn
    yn use(:test3_interface).south(5)
  end
end

Vedeu.interface :test4_interface do
  border do
    title 'Test 4'
  end
  geometry do
    x  use(:help2_interface).x
    y  use(:help2_interface).south
    xn use(:help2_interface).xn
    yn use(:help2_interface).south(5)
  end
end

Vedeu.interface :help4_interface do
  geometry do
    x  use(:test4_interface).x
    y  use(:test4_interface).south
    xn use(:test4_interface).xn
    yn use(:test4_interface).south(5)
  end
end

Vedeu.interface :test5_interface do
  border do
    title 'Test 5'
  end
  geometry do
    x  use(:help1_interface).x
    y  use(:help3_interface).south
    xn use(:help1_interface).xn
    yn use(:help3_interface).south(5)
  end
end

Vedeu.interface :help5_interface do
  geometry do
    x  use(:test5_interface).x
    y  use(:test5_interface).south
    xn use(:test5_interface).xn
    yn use(:test5_interface).south(5)
  end
end

Vedeu.interface :test6_interface do
  border do
    title 'Test 6'
  end
  geometry do
    x  use(:help4_interface).x
    y  use(:help4_interface).south
    xn use(:help4_interface).xn
    yn use(:help4_interface).south(5)
  end
end

Vedeu.interface :help6_interface do
  geometry do
    x  use(:test6_interface).x
    y  use(:test6_interface).south
    xn use(:test6_interface).xn
    yn use(:test6_interface).south(5)
  end
end
