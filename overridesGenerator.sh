###### Ark String Crafting Cost Override Builder 
#####	by fancy_bandage aka somegamerthatgames aka boondoggles aka pDubb
#######
##############
#
# I hope everyone who comes across this can make use of it. There are likely 
# many head-scratching 'faults' in my code, but at least some of them were 
# placed there for readability, the audience perhaps not being someone overly 
# familiar with coding, bash scripts, and the rest. 
#
# You can hit me up at throwaway.nonsense.nope@gmail.com
#############################################################################

echo -e "Copy and paste everything below this line into your Game.ini\n" > configOverrides.txt

function generateResourceBlock { 
	RESOURCE_REQUIREMENT_BLOCK="BaseCraftingResourceRequirements=("
		for (( i=0; i < $NUMBER_OF_UNIQUE_CRAFTING_MATERIALS; i++ ))
		do
			if (( i == 0 ))
				then 
					BASE_RESOURCE_REQUIREMENTS=$(( ${QUANTITY_MODIFIER} * ${CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE[i]} / 2000 ))
				else
					BASE_RESOURCE_REQUIREMENTS=$(( ${QUANTITY_MODIFIER} * ${CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE[i]} / 1000 ))
			fi

			RESOURCE_REQUIREMENT_BLOCK+="(ResourceItemTypeString=\"${CRAFTING_MATERIALS[i]}\",BaseResourceRequirement=${BASE_RESOURCE_REQUIREMENTS}.0,bCraftingRequireExactResourceType=${STRICT_CRAFTING})"

			COMMA_CHECK=$(( i + 1 ))

			if (( $COMMA_CHECK < $NUMBER_OF_UNIQUE_CRAFTING_MATERIALS ))
			then
				# there are more materials, so add a comma
				RESOURCE_REQUIREMENT_BLOCK+=","
			else
				# there are no more materials, so end the block with )
				RESOURCE_REQUIREMENT_BLOCK+=")"
			fi

		done 
	echo -e "${RESOURCE_REQUIREMENT_BLOCK}\n"
}

function verifyStructureExistenceToAdd {
	if [[ "$MATERIAL" != "greenhouse" ]]
	then
		echo "the $MATERIAL $STRUCTURE is not made of greenhouse, so we will generate a block" 
		generateResourceBlock
	elif [[ "$STRUCTURE" != "foundation" && "$STRUCTURE" != "pillar"  ]]
	then
		echo "the $STRUCTURE is not a pillar or foundation"
		generateResourceBlock
	fi
}

# a couple of arrays for materials and structure type, for a loop later
MATERIAL_TYPES=(
	"wood" 
	"stone" 
	"greenhouse"
	)

STRUCTURE_TYPES=(
	"foundation" "pillar" 
	"wall" "railing" 
	"window" 
	"door frame" "door" 
	"dbl door frame" "dbl door" 
	"ceiling"
	)

CRAFTING_COST_MODIFIER_PERCENTAGE="${1:-100}"
STRICT_CRAFTING=false;

# establish a baseline string for structure IDs, more later and then add
# relevant sections inside MATERIAL loop but OUTSIDE structure loop, etc.
STRUCTURE_PREFIX="PrimalItemStructure"

for MATERIAL in "${MATERIAL_TYPES[@]}"
do
	echo -e "\n$MATERIAL structures: \n"
	for STRUCTURE in "${STRUCTURE_TYPES[@]}"
	do

		# more or less, the trailhead
		ITEM_CLASS_STRING=${STRUCTURE_PREFIX}

		if [[ "$STRUCTURE" == *"dbl"* ]]
		then
			ITEM_CLASS_STRING+="_DoubleDoor"

			
			if [[ "$STRUCTURE" == *"frame"* ]]
			then
				ITEM_CLASS_STRING+="frame"
			fi

			case $MATERIAL in
				wood)
					ITEM_CLASS_STRING+="_Wood_C"
					CRAFTING_MATERIALS=("PrimalItemResource_Wood_C" "PrimalItemResource_Thatch_C" "PrimalItemResource_Fibers_C")
					NUMBER_OF_UNIQUE_CRAFTING_MATERIALS=${#CRAFTING_MATERIALS[@]}
					;;
				stone)
					ITEM_CLASS_STRING+="_Stone_C"
					CRAFTING_MATERIALS=("PrimalItemResource_Stone_C" "PrimalItemResource_Wood_C" "PrimalItemResource_Thatch_C")
					NUMBER_OF_UNIQUE_CRAFTING_MATERIALS=${#CRAFTING_MATERIALS[@]}
					;;
				greenhouse)
					ITEM_CLASS_STRING+="_Greenhouse_C"
					CRAFTING_MATERIALS=("PrimalItemResource_MetalIngot_C" "PrimalItemResource_Crystal_C" "PrimalItemResource_ChitinPaste_C")
					NUMBER_OF_UNIQUE_CRAFTING_MATERIALS=${#CRAFTING_MATERIALS[@]}
					;;
			esac

			case $STRUCTURE in
				"dbl door frame")
					PRIMARY_MATERIAL_BASE_QUANTITY=40
					
					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
				"dbl door")
					PRIMARY_MATERIAL_BASE_QUANTITY=30

					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
			esac
		fi	

		# handle all the other items
		if [[ "$ITEM_CLASS_STRING" == "${STRUCTURE_PREFIX}" ]]
		then

			case $MATERIAL in
				wood)
					ITEM_CLASS_STRING+="_Wood"
					CRAFTING_MATERIALS=("PrimalItemResource_Wood_C" "PrimalItemResource_Thatch_C" "PrimalItemResource_Fibers_C")
					NUMBER_OF_UNIQUE_CRAFTING_MATERIALS=${#CRAFTING_MATERIALS[@]}
					;;
				stone)
					ITEM_CLASS_STRING+="_Stone"
					CRAFTING_MATERIALS=("PrimalItemResource_Stone_C" "PrimalItemResource_Wood_C" "PrimalItemResource_Thatch_C")
					NUMBER_OF_UNIQUE_CRAFTING_MATERIALS=${#CRAFTING_MATERIALS[@]}
					;;
				greenhouse)
					ITEM_CLASS_STRING+="_Greenhouse"
					CRAFTING_MATERIALS=("PrimalItemResource_MetalIngot_C" "PrimalItemResource_Crystal_C" "PrimalItemResource_ChitinPaste_C")
					NUMBER_OF_UNIQUE_CRAFTING_MATERIALS=${#CRAFTING_MATERIALS[@]}
					;;
			esac

			case $STRUCTURE in
				"foundation")
					ITEM_CLASS_STRING+="Floor_C"
					PRIMARY_MATERIAL_BASE_QUANTITY=80

					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
				"pillar")
					ITEM_CLASS_STRING+="Pillar_C"
					PRIMARY_MATERIAL_BASE_QUANTITY=40

					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
				"railing")
					ITEM_CLASS_STRING+="Railing_C"
					PRIMARY_MATERIAL_BASE_QUANTITY=20

					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
				"wall")
					ITEM_CLASS_STRING+="Wall_C"
					PRIMARY_MATERIAL_BASE_QUANTITY=40

					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
				"window")
					ITEM_CLASS_STRING+="WallWithWindow_C"
					PRIMARY_MATERIAL_BASE_QUANTITY=36

					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
				"door frame")
					ITEM_CLASS_STRING+="WallWithDoor_C"
					PRIMARY_MATERIAL_BASE_QUANTITY=30

					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
				"door")
					ITEM_CLASS_STRING+="Door_C"
					PRIMARY_MATERIAL_BASE_QUANTITY=20

					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
				"ceiling")
					ITEM_CLASS_STRING+="Ceiling_C"
					PRIMARY_MATERIAL_BASE_QUANTITY=60

					QUANTITY_MODIFIER=$(( ${PRIMARY_MATERIAL_BASE_QUANTITY} * CRAFTING_COST_MODIFIER_PERCENTAGE / 100 ))
					CRAFTING_QUANTITIES_BY_QUANTITATIVE_PERCENTAGE=(1000 250 125)

					verifyStructureExistenceToAdd
					;;
			esac
		fi

		OVERRIDE_ITEM_CRAFTING_COSTS="ConfigOverrideItemCraftingCosts=(ItemClassString=\"${ITEM_CLASS_STRING}\",${RESOURCE_REQUIREMENT_BLOCK})"

		echo -e "${OVERRIDE_ITEM_CRAFTING_COSTS}\n" >> configOverrides.txt
	done
done
