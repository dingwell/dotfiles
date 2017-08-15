#!/usr/bin/env python
# -*- coding: utf-8 -*-
#
{fileheader}

import multiprocessing  # Parallel processing (use multiple CPUs)

def process_task(task):    
    # Print information about what the process is up to:
    pname=multiprocessing.current_process().name  # Name of current process
    print "%s Processing task: %s"%(pname, task)
    
    # Do stuff specific for the given task
    # (this is where the main data crunching should take place)
    
    return 0
    

def main(args):
    # Global variables which will be set with some help from ArgumentParser:
    global verbose,debug
    
    description = "<<PUT A HELPFUL DESCRIPTION HERE>>"
    
    # Parse arguments:
    import argparse
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('main_args',
        type=str, nargs='+', metavar='MAIN ARGUMENTS',
        help="Main argument of program which consists of 1 or more 'words'")
    parser.add_argument('-j','--jobs', required=False,
        type=int, metavar='N', default=1,
        help='Number of parallel jobs to launch')
    parser.add_argument('-v','--verbose', required=False,
        action='store_true',
        help='Use to print more diagnostics to stdout')
    parser.add_argument('-d','--debug', required=False,
        action='store_true',
        help="Create additional debug info (intermediate output files and stdout)")
    parser.add_argument('-p','--debug-point', required=False,
        type=int, nargs=3, metavar=('x','y','t'), default=[1,1,0],
        help="Print value of this and surrounding points to stdout "\
            +"(if '-d' is set) (EXAMPLE ONLY; NOT IMPLEMENTED IN TEMPLATE!)")
    args = parser.parse_args()
    
    # Propagate values to local/global variable names:
    tasks   = args.main_args
    verbose = args.verbose
    debug   = args.debug
    #pt_xyt = args.debug_point
    
    # Begin parallel or serial processing based on user input:
    if args.jobs > 1:
        # Create a process pool:
        print "Spawning %d child processes"%n_proc
        pool = multiprocessing.Pool(processes=n_proc)
        
        # Run until finished or a keyboard interrupt is caught:
        try:
            results = pool.map_async(process_directory, tasks).get(999999)  
        except KeyboardInterrupt:
            pool.terminate()
            print "You cancelled the program!"
            sys.exit(1)
            
        print "Exit codes: ", results
            
        print "Finished parallel processing!"
    else:
        for t in tasks:
            process_task(t)
        print "Finished serial processing!"
    
    return 0

if __name__ == '__main__':
    import sys
    sys.exit(main(sys.argv))
