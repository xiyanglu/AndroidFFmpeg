//
// Created by 郭鹤 on 16/6/24.
//

#include <setjmp.h>

#include "ffmpeg_cmd.h"
#include "ffmpeg.h"
#include "cmdutils.h"

jmp_buf jmp_exit;

int run_cmd(int argc, char** argv)
{
	int res = 0;
	if(res = setjmp(jmp_exit))
	{
	    return res;
	}

    res = run(argc, argv);
    return res;
}
