#set -x
typeset -i seq=0
typeset -i innerseq=0
print -n 'Last SEQ: '
read seq
while `true`
do

print -n '     Task template:'
read task
print -n '     Role template ids:'
read role

for i in $role
do
	print -n "Task $task Role $i Hours: "
	read hours
	if [ $hours -eq 0 ]
	then
		func='NO_OP'
	else
		print -n "func: "
		read func
	fi
	let seq=$seq+1
	print -n "Insert into role_to_task_template (ID,TASK_TEMPLATE_ID,ROLE_TEMPLATE_ID,
CALCULATION_NAME) values ($seq," >> rtt
	print -n "$task, $i, '$func');" >> rtt
	print "" >> rtt
	print "" >> rtt
	if [ $func != 'NO_OP' ]
	then
print "/**\n\
* @param RoleToTaskInstCVE\n\
* @param TraceEstimateCVE\n\
* @return double hours\n\
* based on taskID $task roleID $i\n\
* returns the number of hours expected for this role and task\n\
*/\n\
\n\
public static CalcBase $func = new CalcBase(\"$func\")\
{\n\
    public double runHourCalculation(RoleToTaskTemplateCVE rtt, TraceEstimateCVE est)\n\
    {\n\
        double unitCost = $hours;\n\
        return 0.0;\n\
    }\n\
};\n\
\n\
\n" >> funcs
fi
print -n "hit enter to flush"
read $blah
done
done
