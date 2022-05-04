fun round file = 
    let
        fun parse file =
            let
                (* A function to read an integer from specified input. *)
                fun readInt input = 
                Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

                (* Open input file. *)
                val inStream = TextIO.openIn file

                (* Read an integer (number of countries) and consume newline. *)
                val n = readInt inStream
                val k = readInt inStream
                val _ = TextIO.inputLine inStream

                (* A function to read N integers from the open file. *)
                fun readInts 0 acc = rev acc
                    | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
            in
                (n, k, readInts k [])
            end
        
        val tuple = parse file
        val N = #1 tuple
        val K = #2 tuple
        val init_state = #3 tuple

        fun create_state (x, y, acc) =
            if y < K then
                create_state (x, y + 1, x :: acc)
            else
                acc
        
        fun create_distance (l1, l2, acc) =
            if null l1 orelse null l2 then
                rev acc
            else
                if hd l1 >= hd l2 then
                    create_distance (tl l1, tl l2, (hd l1 - hd l2) :: acc)
                else
                    create_distance (tl l1, tl l2, (N - hd l2 + hd l1) :: acc)
        
        fun sum [] = 0
            | sum (h :: t) = h + sum t

        fun max (x, []) = x
            | max (x, h :: t) =
                if h > x then 
                    max (h, t)
                else
                    max (x, t)

        fun foo (i, acc) = 
            if i < N then
                let
                    val temp1 = create_state (i, 0, [])
                    val temp2 = create_distance (temp1, init_state, [])
                    val temp3 = max (0, temp2)
                    val temp4 = sum (temp2)
                in
                    if temp3 <= temp4 - temp3 + 1 then
                        foo (i + 1, temp4 :: acc)
                    else
                        foo (i + 1, ~1 :: acc)
                end
            else
                rev acc

        fun min (x, []) = x
            | min (x, h :: t) =
                if h < x andalso h >= 0 then
                    min (h, t)
                else
                    min (x, t)

        val myList = foo (0, [])
        val M = min (1000000000, myList)

        fun scan (i, l) =
            if hd l = M then
                i
            else
                scan (i + 1, tl l)

        val C = scan (0, myList)
    in
        print (Int.toString(M) ^ " " ^ Int.toString(C) ^ "\n")
    end;
