package main

import (
	"fmt"
	"os"
	"os/exec"
	"strings"
)

var GoBinPath string

func addDynamicTag(args []string) []string {
	for i, a := range args {
		if strings.Contains(a, "-tags=") {
			args[i] = a + ",dynamic"
			return args
		}
	}
	args = append(args, "")
	copy(args[2:], args[1:])
	args[1] = "-tags=dynamic"
	return args
}

func main() {
	pwd, _ := os.Getwd()
	goArgs := os.Args[1:]
	subcommand := goArgs[0]
	switch subcommand {
	case
		"build",
		"test",
		"install":
		goArgs = addDynamicTag(goArgs)
	}

	cmd := exec.Command(GoBinPath, goArgs...)
	cmd.Dir = pwd
	stdout, err := cmd.Output()

	if err != nil {
		fmt.Println(err.Error())
		return
	}

	fmt.Println(string(stdout))
}
