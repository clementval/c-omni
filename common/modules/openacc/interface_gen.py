# type = ('integer', 'real', 'logical', 'complex', 'character')
type = ('integer', 'real', 'logical', 'character')
dimension = (1, 2, 3, 4)
dim_map = (':', ':,:', ':,:,:', ':,:,:,:')

# subroutine acc_copyout_async( a, async )
#  type, dimension(:[,:]. . . ) :: a
#  integer(acc_handle_kind) :: async

module_procedure = []

interface_only = False
is_function = True

# with open("base_signature") as file:
with open("base_function") as file:
    file_content = file.readlines()
    for line in file_content:
        parts = line.split('/')
        subroutine_name = parts[0]
        parameters = parts[1].rstrip('\r\n')
        nb_params = len(parameters.split(','))

        print('! Automatically generated signatures for ' + subroutine_name)
        for t in type:
            if 'len' in parameters:
                suffix = '_' + t[0] + '_l_p' + str(nb_params)
                sname = subroutine_name + suffix
                module_procedure.append(sname)
                if not interface_only:
                    if is_function:
                        print('logical function ' + sname + parameters)
                    else:
                        print('subroutine ' + sname + parameters)
                    print('  ' + t + ' :: a')
                    if len(parts) > 2:
                        for p in parts[2:]:
                            print('  ' + p.rstrip('\r\n'))
                    if is_function:
                        print('end function ' + sname)
                    else:
                        print('end subroutine ' + sname)
                    print('')
            else:
                for d in dimension:
                    suffix = '_' + t[0] + '_' + str(d) + 'd_p' + str(nb_params)
                    sname = subroutine_name + suffix
                    module_procedure.append(sname)
                    if not interface_only:
                        if is_function:
                            print('logical function ' + sname + parameters)
                        else:
                            print('subroutine ' + sname + parameters)
                        print('  ' + t + ', dimension(' + dim_map[d - 1] + ') :: a')
                        if len(parts) > 2:
                            for p in parts[2:]:
                                print('  ' + p.rstrip('\r\n'))
                        if is_function:
                            print('end function ' + sname)
                        else:
                            print('end subroutine ' + sname)
                        print('')

        if interface_only:
            print('interface ' + subroutine_name)
            print('  module procedure &')
            for sname in module_procedure[:-1]:
                print('    ' + sname + ', &')
            print('    ' + module_procedure[-1])
            print('end interface')
            module_procedure = []