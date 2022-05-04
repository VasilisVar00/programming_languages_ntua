fun longest(file) =
  let

    fun parse (file) =
      let

        fun readInt input = Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

        val inStream = TextIO.openIn file
        val (n, m) = (readInt inStream, readInt inStream) (* n= hmeres, m = nosokomeia*)
        val _ = TextIO.inputLine inStream

        fun readInts 0 acc = rev acc (* Replace with 'rev acc' for proper order. *)
            | readInts i acc = readInts (i - 1) (readInt inStream :: acc)

      in
        (n,m,readInts n [])
      end

      val tuple = parse(file)
      val M = #1 tuple        (*arithmos hmerwn*)
      val N = #2 tuple        (*rithmos nosokomeiwn*)
      val list = #3 tuple




fun theMax(a,b) =
  if a > b then a else b

fun theMin(a,b) =
  if a < b then a else b


fun modify([], b, N) = b
  | modify(h::t, b,N) =
    let
      val new = ~h - N
    in
    modify(t, new::b,N)
    end

fun prefix([], a) = a                         (* prefix of the reversed is suffix for the list *)
  | prefix(h::t, []) = prefix(t, [h])
  | prefix (h::t, a) =
    let
      val y = h + hd(a)
    in
    prefix(t, y::a)
    end

    (*prefix(rev(modify(list, [])), [])*)

fun minLeft([], a) = a
  | minLeft(h::t, []) = minLeft(t , [h])
  | minLeft(h::t, a) =
   let
      val minimum = theMin(h,hd(a))
   in
   minLeft(t , minimum::a)
   end

fun maxRight([], a) = a                                   (* give the function the list in reverse order*)
  | maxRight(h::t, []) = maxRight(t, [h])
  | maxRight(h::t, a) =
   let
      val maximum = theMax(h, hd(a))
   in
   maxRight(t, maximum::a)
   end

fun simpleCheck([], ans,index) = ans
  | simpleCheck(h::t, ans, index) =
    let
      val v2 = index + 1
      val v1 = ans
    in
      if h >= 0 then
        let
          val v1 = index
        in
          simpleCheck(t,v1+1, v2)
       end
      else simpleCheck(t, v1, v2)
    end


fun check([], [], count1,count2,ans) = ans
  | check([], y::ys,count1,count2,ans) = ans
  | check(x::xs, [],count1,count2,ans) = ans
  | check(x::xs, y::ys,count1,count2,ans) =
  if x >= y then check(xs, y::ys, count1+1, count2, ans)
  else check(x::xs, ys, count1, count2+1, theMax(count2 - count1, ans))

fun answer(list, N) =
let
  val aux1 = rev(modify(list, [], N))
  val aux3 = prefix(aux1, [])
  val aux4 = rev(aux3)
  val aux5 = minLeft(aux4, [])
  val aux6 = maxRight(aux3, [])
  val aux7 = rev(aux5)
in
  theMax(check(aux7, aux6, 0, 0, 0), simpleCheck(aux4,0,0))
end

fun printAnswer(a) =
  print(Int.toString (a)^"\n")

in
  printAnswer(answer(list,N))
end;
