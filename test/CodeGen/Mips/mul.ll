; RUN: llc  -march=mipsel -mattr=mips16 -relocation-model=pic -O3 -verify-loop-info < %s | FileCheck %s -check-prefix=16

@iiii = global i32 5, align 4
@jjjj = global i32 -6, align 4
@kkkk = common global i32 0, align 4

define void @test() nounwind {
entry:
  %0 = load i32, i32* @iiii, align 4
  %1 = load i32, i32* @jjjj, align 4
  %mul = mul nsw i32 %1, %0
; 16:	mult	${{[0-9]+}}, ${{[0-9]+}}
; 16: 	mflo	${{[0-9]+}}

  store i32 %mul, i32* @kkkk, align 4
  ret void
}
