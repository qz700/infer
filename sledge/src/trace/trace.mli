(*
 * Copyright (c) 2018-present, Facebook, Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

(** Debug trace logging *)

(** Tracing configuration for a toplevel module. *)
type trace_mod_funs =
  { trace_mod: bool option
        (** Enable/disable tracing of all functions in module *)
  ; trace_funs: bool Map.M(String).t
        (** Enable/disable tracing of individual functions *) }

type config =
  { trace_all: bool  (** Enable all tracing *)
  ; trace_mods_funs: trace_mod_funs Map.M(String).t
        (** Specify tracing of individual toplevel modules *) }

val init : ?margin:int -> config:config -> unit -> unit
(** Initialize the configuration of debug tracing. *)

type 'a printf = ('a, Formatter.t, unit) format -> 'a
type pf = {pf: 'a. 'a printf}

val info : string -> string -> 'a printf
(** Emit a message at the current indentation level, if enabled. *)

val call : string -> string -> (pf -> 'b) -> 'b
(** Increase indentation level and emit a message, if enabled. *)

val retn : string -> string -> (pf -> 'b -> unit) -> 'b -> 'b
(** Decrease indentation level and emit a message, if enabled. *)

val flush : unit -> unit
(** Flush the internal buffers. *)

val report : ('a, Formatter.t, unit, bool) format4 -> 'a
(** Emit a message at the current indentation level, and return [false]. *)
