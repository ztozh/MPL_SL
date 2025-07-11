# Copyright (C) Matway Burkow
#
# This repository and all its contents belong to Matway Burkow (referred here and below as "the owner").
# The content is for demonstration purposes only.
# It is forbidden to use the content or any part of it for any purpose without explicit permission from the owner.
# By contributing to the repository, contributors acknowledge that ownership of their work transfers to the owner.

"Array.Array"    use
"control.Ref"    use
"control.assert" use
"control.dup"    use
"control.times"  use
"control.when"   use

Deque: [
  Item:;
  {
    SCHEMA_NAME: "Deque<" @Item schemaName & ">" & virtual;

    # front: head tail :back
    virtual CONTAINER: ();
    virtual DEQUE: ();
    virtual elementType: @Item Ref;
    head: @elementType Array;
    tail: @elementType Array;

    iter: [
      {
        deque: @self;
        key:   0;

        next: [
          key deque.size = [@deque.@elementType FALSE] [
            key @deque.at
            key 1 + !key
            TRUE
          ] if
        ];
      }
    ];

    size: [head.size tail.size +];

    pushBack: [@tail.append];

    pushFront: [@head.append];

    popBack: [
      tail.size 0 = [@head @tail swapBuffers] when
      @tail.popBack
    ];

    popFront: [
      head.size 0 = [@tail @head swapBuffers] when
      @head.popBack
    ];

    back: [
      tail.size 0 = [
        0 @head.at
      ] [
        @tail.last
      ] if
    ];

    front: [
      head.size 0 = [
        0 @tail.at
      ] [
        @head.last
      ] if
    ];

    at: [
      index:;
      index head.size < [
        head.size index - 1 - @head.at
      ] [
        index head.size - @tail.at
      ] if
    ];

    swapBuffers: [
      from: to:;;

      swapCount: from.size 1 + 2 /;

      [to.size 0 =] "Destination must be empty!" assert
      swapCount @to.resize

      swapCount [
        i @from.at
        swapCount 1 - i - @to.at set
      ] times

      from.size swapCount - [
        i swapCount + @from.at
        i @from.at set
      ] times

      from.size swapCount - @from.shrink
    ];

    clear: [
      @head.clear
      @tail.clear
    ];

    release: [
      @head.release
      @tail.release
    ];
  }
];
