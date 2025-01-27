/*********************Ebonumba TOPOR****************/
/obj/item/twohanded/required/paxe
	name = "poleaxe"
	desc = "One of the most versatile weapons ever made."
	icon = 'code/shitcode/maxsc/icons/axe.dmi'
	icon_state = "axe1"
	item_state = "paxe1"
	lefthand_file = 'code/shitcode/maxsc/icons/lefthand.dmi'
	righthand_file = 'code/shitcode/maxsc/icons/righthand.dmi'
	block_chance = 10
	slot_flags = ITEM_SLOT_BACK
	force = 5
	force_wielded = 15
	throwforce = 20
	attack_verb = list("attacked", "chopped", "cleaved", "torn", "cut")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP
	materials = list(MAT_METAL=5000)
	max_integrity = 200

/obj/item/twohanded/required/paxe/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 110)

/obj/item/twohanded/required/paxee
	name = "poleaxe of law"
	desc = "One of the most versatile weapons ever made. You can even bring law with it."
	icon = 'code/shitcode/maxsc/icons/axe.dmi'
	icon_state = "axe1"
	item_state = "paxe1"
	lefthand_file = 'code/shitcode/maxsc/icons/lefthand.dmi'
	righthand_file = 'code/shitcode/maxsc/icons/righthand.dmi'
	block_chance = 0
	slot_flags = ITEM_SLOT_BACK
	force = 5
	force_wielded = 20
	throwforce = 20
	attack_verb = list("attacked", "brought law to", "cleaved", "pierced")
	hitsound = 'sound/weapons/bladeslice.ogg'
	sharpness = IS_SHARP
	materials = list(MAT_METAL=5000)
	max_integrity = 200
	var/charged = TRUE
	var/recharge_time = 600

/obj/item/twohanded/required/paxee/Initialize()
	. = ..()
	AddComponent(/datum/component/butchering, 60, 110)

/obj/item/twohanded/required/paxee/attack_self(mob/user)
	if (charged)
		to_chat(user, "<span class='notice'>You prepared to bring law.</span>")
		charged = FALSE
		block_chance = 100
		sleep(30)
		block_chance = 0
		addtimer(CALLBACK(src, .proc/Recharge), recharge_time)

/obj/item/twohanded/required/paxee/proc/Recharge()
	if(!charged)
		charged = TRUE

/obj/item/twohanded/required/paxee/examine(mob/living/user)
	..()
	if (charged)
		to_chat(user, "You feel an incredible aura while looking at this.")
	else
		to_chat(user, "It seems normal.")

/obj/item/twohanded/required/paxee/attack(mob/living/target, mob/living/carbon/user)
	if (istype(user, /mob/living/carbon/human/) && block_chance == 100)
		var/mob/living/carbon/human/H = user
		H.say("AD MORTEM INIMICUS!!!", ignore_spam = TRUE)
	..()

