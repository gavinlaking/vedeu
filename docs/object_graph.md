# @title Producing an object graph of Vedeu

Sometimes I find looking at the project as a graph helps me to
understand the relationship between the various objects. To achieve
this, I use Yard's graph options. If this sort of thing floats your
boat too, and you have the appropriate software installed:

```shell
yard graph --full --dependencies --private --protected --dot --file vedeu.dot

dot -Tpdf vedeu.dot -o vedeu.pdf
```

Cool stuff.
