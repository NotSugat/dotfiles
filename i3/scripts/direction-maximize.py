import sys
from i3ipc import Connection


def get_data(current):
    rightmost = True
    bottommost = True

    while True:
        if current.type == "workspace":
            return rightmost, bottommost

        parent = current.parent
        children = parent.nodes

        for i, child in enumerate(children):
            if child.id == current.id:
                current_i = i

        if current_i != len(children) - 1:
            match parent.layout:
                case "splith":
                    rightmost = False
                case "splitv":
                    bottommost = False

        current = parent


def main():
    direction = sys.argv[1]
    amount = sys.argv[2]

    i3 = Connection()
    tree = i3.get_tree()
    focused = tree.find_focused()

    rightmost, bottommost = get_data(focused)

    match direction:
        case "left":
            if rightmost:
                i3args = "grow left"
            else:
                i3args = "shrink right"
        case "right":
            if rightmost:
                i3args = "shrink left"
            else:
                i3args = "grow right"
        case "up":
            if bottommost:
                i3args = "grow up"
            else:
                i3args = "shrink down"
        case "down":
            if bottommost:
                i3args = "shrink up"
            else:
                i3args = "grow down"

    i3.command(f"resize {i3args} {amount} px")


if __name__ == "__main__":
    main()
