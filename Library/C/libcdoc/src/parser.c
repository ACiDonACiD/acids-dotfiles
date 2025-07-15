#include <stdio.h>
#include <stdlib.h>
#include <error.h>
#include <argp.h>

#define MAX_ARG 8
#define OPT_ABORT 1

/* Program version */
const char *argp_program_version = "1.0.4";

/* Program address */
const char *argp_program_bug_address = "<report-bug@autodoc.org>";

/* Program documentation */
static char doc[] = "A program to process a required BUFFER string and optional STRVAR strings.\n"
                    "Example: program buffer str1 str2 --verbose";

/* A description of the arguments to accept */
static char args_doc[] = "BUFFER [STRVAR...]";

/* Used by main() to communicate with parse_opt() */
struct arguments {
    char *buffer;    /* Required BUFFER argument */
    char **strvar;   /* Optional STRVAR arguments */
    int strvar_count; /* Number of STRVAR arguments */
    int silent, verbose, abort;
};

/* The options we understand */
static struct argp_option options[] = {
    {"verbose", 'v', 0, 0, "Produce verbose output"},
    {"quiet", 'q', 0, 0, "Don't produce any output"},
    {"silent", 's', 0, OPTION_ALIAS},
    {0, 0, 0, 0, "The following options should be grouped together:"},
    {"abort", OPT_ABORT, 0, 0, "Abort before showing any output"},
    {0}
};

/* Parse each option individually */
static error_t parse_opt(int key, char *arg, struct argp_state *state) {
    struct arguments *arguments = (struct arguments *)state->input;

    switch (key) {
        case 'q':
        case 's': /* -q quiet | -s silent */
            arguments->silent = 1;
            break;
        case 'v': /* -v verbose */
            arguments->verbose = 1;
            break;
        case OPT_ABORT: /* --abort */
            arguments->abort = 1;
            break;
        case ARGP_KEY_ARG:
            if (state->arg_num == 0) {
                if (arg && *arg) { /* Ensure non-empty BUFFER */
                    arguments->buffer = arg;
                } else {
                    argp_error(state, "BUFFER argument cannot be empty");
                    return EINVAL;
                }
            } else {
                /* Additional arguments go to STRVAR */
                if (state->arg_num > MAX_ARG) {
                    argp_error(state, "Too many arguments (max %d)", MAX_ARG);
                    return EINVAL;
                }
                return ARGP_ERR_UNKNOWN; /* Let ARGP_KEY_ARGS handle it */
            }
            break;
        case ARGP_KEY_ARGS:
            arguments->strvar = &state->argv[state->next];
            arguments->strvar_count = state->argc - state->next;
            if (arguments->strvar_count > MAX_ARG - 1) {
                argp_error(state, "Too many STRVAR arguments (max %d)", MAX_ARG - 1);
                return EINVAL;
            }
            state->next = state->argc;
            break;
        case ARGP_KEY_NO_ARGS:
            argp_error(state, "Missing required BUFFER argument");
            return EINVAL;
        case ARGP_KEY_END:
            if (!arguments->buffer) {
                argp_error(state, "Missing required BUFFER argument");
                return EINVAL;
            }
            break;
        default:
            return ARGP_ERR_UNKNOWN;
    }
    return 0;
}

int main(int argc, char **argv) {
    struct arguments arguments = {
        .buffer = NULL,
        .strvar = NULL,
        .strvar_count = 0,
        .verbose = 0,
        .silent = 0,
        .abort = 0
    };

    struct argp argp = {
        .options = options,
        .parser = parse_opt,
        .doc = doc,
        .args_doc = args_doc,
=        .children = NULL,
        .help_filter = NULL,
        .argp_domain = NULL
    };

    /* Parse the arguments */
    int status = argp_parse(&argp, argc, argv, 0, 0, &arguments);
    if (status != 0) {
        fprintf(stderr, "Error parsing arguments: %d\n", status);
        return EXIT_FAILURE;
    }

    if (arguments.abort) {
        error(10, 0, "ABORTED");
    }

    if (!arguments.silent) {
        printf("ARG_1 = %s\n", arguments.buffer ? arguments.buffer : "(none)");
        printf("ARG_2 = ");
        if (arguments.strvar && arguments.strvar_count > 0) {
            for (int i = 0; i < arguments.strvar_count; i++) {
                printf(i == 0 ? "%s" : ", %s", arguments.strvar[i]);
            }
        } else {
            printf("(none)");
        }
        printf("\n===== OPTIONS =====\n");
        printf("VERBOSE: %s\nSILENT: %s\n",
               arguments.verbose ? "yes" : "no",
               arguments.silent ? "yes" : "no");
    }

    return EXIT_SUCCESS;
}
