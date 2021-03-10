#switch 

#Switch statements compare a single test value to multiple conditions, and performs any associated actions for
#successful comparisons. It can result in multiple matches/actions.
#The -CaseSensitive parameter enforces switch statements to perform exact, case-sensitive matching against conditions.
#The -Wildcard parameter allows switch statements to perform wildcard matching against conditions.
#The -file parameter allows the switch statement to receive input from a file. Each line of the file is evaluated by the switch statement.
#The Default keyword is used to execute an action when no other conditions match the input value.
#The -Regex parameter allows switch statements to perform regular expression matching against conditions.
#The -Exact parameter enforces switch statements to perform exact, case-insensitive matching against stringconditions.

#Simple Switch

$value=1

switch($value){

    '1' {
        ipconfig
    }
    '2' {
        netstat -na
    }

}


#Switch Statement with Wildcard Parameter

<#
The -Wildcard parameter allows switch statements to perform wildcard matching against conditions.
Example:#>
switch -Wildcard ('Condition')
    {
        'Condition' {'Normal match'}
        'Condit*' {'Zero or more wildcard chars.'}
        'C[aoc]ndit[f-l]on' {'Range and set of chars.'}
        'C?ndition' {'Single char. wildcard'}
        'Test*' {'No match'}
    }
<#
Output:
    Normal match
    Zero or more wildcard chars.
    Range and set of chars.
    Single char. wildcard
#>