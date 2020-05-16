// Learn more about F# at http://fsharp.org

let rec printParts n k = 
    if n = k && n > 0 then
        [List.replicate n 1]
    else if n > k && k > 0 then
        let startWithOne = 
            printParts (n-1) (k-1)
            |> List.map (fun x -> 1::x)
        let startWithElse = 
            printParts (n-k) k
            |> List.map (fun x -> List.map ((+) 1) x)
        startWithOne @ startWithElse
    else
        List.empty

let printList n k lst = 
    printfn "Number of integer parts of %d into %d is %d"  n k (List.length lst)
    List.iter (fun elt -> printfn "%A" elt) lst
        

[<EntryPoint>]
let main argv =
    let n = int argv.[0]
    let k = int argv.[1]
    printParts n k
    |> printList n k
    0
