(*
 * Copyright (c) 2018-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd
open OUnit2

let test_parser =
  let create_test input expected _ =
    let found = Perf_profiler_j.perf_profiler_of_string input in
    assert_equal expected found
  in
  [ ("test_parser_1", "[]", [])
  ; ( "test_parser_2"
    , {|[{"function_name":"pkg/cls::\u003Cclinit>","avg_inclusive_cpu_time_ms":123.01234567899,"avg_exclusive_cpu_time_ms":9.8765432123456}]|}
    , [ { Perf_profiler_t.function_name= "pkg/cls::<clinit>"
        ; avg_inclusive_cpu_time_ms= 123.01234567899
        ; avg_exclusive_cpu_time_ms= 9.8765432123456 } ] ) ]
  |> List.map ~f:(fun (name, test_input, expected_output) ->
         name >:: create_test test_input expected_output )


let tests = "java_profiler_samples" >::: test_parser
