Pruning the keyspace
====================

A new ISP has come to town and distributed 3G Wifi pocket hot-spots to
customers all over Melbourne.  They realized early on that customers are bad at
picking passwords, so they've printed out cards with each modem containing a
unique base-station name and password.

They take the form:

    +---------------------------------------------+
    |                                             |
    |           OrsomNET+ Secret Access           |
    |                                             |
    |                                             |
    |     Base station name: OrsomNET B1468D      |
    |              Password: 1C23E49C             |
    |                                             |
    |           "security is paramount"           |
    |                                             |
    +=============================================+

After sighting a few of these cards around the place, you notice that the passwords:

 - never contain more than 2 consequtive characters of the same class (number, letter)
 - never contain adjacent identical characters
 - are always 8 characters in length (the WPA2 minimum it turns out)
 - never contain a zero (too easily confused with capital O?)
 - always have letters present, always in the set A-F (must be hex then)

It seems they've tried to make their passwords appear more random by adding rules.

Write a script!

 - emits passwords with the characteristics described
 - does not repeat passwords inside a run
 - exhausts the available keyspace on completing a run

Regardless of which language you choose, a key aspect of this exercise is to
realize algorithmic shortcuts. Raw speed matters but your approach matters more :D
